module queue #(
    parameter int Size = 16,
    parameter type T = logic,
    parameter int Producers = 1,
    localparam int Width = $clog2(Size),
    localparam int Select = $clog2(Producers)
) (
    input wire clk_ni,
    input wire rst_i,

    input wire push_i[Producers-1:0],
    input T data_i[Producers-1:0],

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

      for (bit [Select:0] i = 0; i < Producers[Select:0]; ++i) begin
        if (push_i[i[Select-1:0]] && size < Size[Width:0]) begin
          data_o[size[Width-1:0]] <= data_i[i[Select-1:0]];
          ++size;
        end
      end

      size_o <= size;
    end
  end
endmodule
