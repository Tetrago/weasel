module queue_tb;
  reg r_clk;
  reg r_rst;
  reg r_push;
  reg [3:0] r_data;
  reg r_pop[3:0];

  wire [2:0] w_size;
  wire [3:0] w_data[3:0];

  queue #(
      .Size(4),
      .T(bit [3:0])
  ) u0 (
      r_clk,
      r_rst,
      r_push,
      r_data,
      r_pop,
      w_size,
      w_data
  );

  function void push(bit [3:0] value);
    r_push = 1;
    r_data = value;
  endfunction

  function void clock;
    #5 r_clk = 1;
    #5 r_clk = 0;

    r_rst  = 0;
    r_push = 0;
    r_pop  = '{default: 0};
  endfunction

  initial begin
    r_clk = 0;
    r_rst = 1;
    r_pop = {0, 0, 0, 0};
    clock;

    push(0);
    clock;

    push(2);
    clock;

    assert (w_size == 2)
    else $error("incorrect size: %d", w_size);
    assert (w_data[0] == 0)
    else $error("incorrect data at 0: %d", w_data[0]);
    assert (w_data[1] == 2)
    else $error("incorrect data at 1: %d", w_data[1]);

    push(4);
    clock;

    push(6);
    clock;

    assert (w_size == 4)
    else $error("incorrect size: %d", w_size);
    assert (w_data[0] == 0)
    else $error("incorrect data at 0: %d", w_data[0]);
    assert (w_data[1] == 2)
    else $error("incorrect data at 1: %d", w_data[1]);
    assert (w_data[2] == 4)
    else $error("incorrect data at 2: %d", w_data[2]);
    assert (w_data[3] == 6)
    else $error("incorrect data at 3: %d", w_data[3]);

    r_pop = {0, 1, 0, 1};
    clock;

    assert (w_size == 2)
    else $error("incorrect size: %d", w_size);
    assert (w_data[0] == 2)
    else $error("incorrect data at 0: %d", w_data[0]);
    assert (w_data[1] == 6)
    else $error("incorrect data at 1: %d", w_data[1]);

    $display("end of test");
  end
endmodule
