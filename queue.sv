module queue #(
    parameter int Size = 16,
    parameter type T = logic,
    localparam int Width = $clog2(Size)
) (
    input wire clk_ni,
    input wire rst_i,

    input wire push_i,
    input T data_i,

    input wire pop_i[Size-1:0],

    output logic [Width:0] size_o,
    output T data_o[Size-1:0]
);
  always_ff @(negedge clk_ni) begin
    if (rst_i) begin
      size_o <= 0;
    end else begin
      bit [  Width:0] size = size_o;
      bit [Width-1:0] index = 0;

      for (bit [Width:0] i = 0; i < Size[Width:0]; ++i) begin
        if (pop_i[i[Width-1:0]]) begin
          --size;
        end else begin
          data_o[index] <= data_o[i[Width-1:0]];
          ++index;
        end
      end

      if (push_i && size_o < Size[Width:0]) begin
        data_o[size_o[Width-1:0]] <= data_i;
        ++size;
      end

      size_o <= size;
    end
  end
endmodule
