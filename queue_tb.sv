module queue_tb;
  logic r_clk;
  logic r_rst;
  logic r_push[1:0];
  logic [3:0] r_data[1:0];
  logic r_pop[3:0];

  wire [2:0] w_size;
  wire [3:0] w_data[3:0];

  queue #(
      .Size(4),
      .T(bit [3:0]),
      .Producers(2)
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
    r_push[0] = 1;
    r_data[0] = value;
  endfunction

  function void clock;
    #5 r_clk = 1;
    #5 r_clk = 0;

    r_rst  = 0;
    r_push = '{default: 0};
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

    r_push = {1, 1};
    r_data[0] = 7;
    r_data[1] = 5;
    clock;

    assert (w_size == 4)
    else $error("incorrect size: %d", w_size);
    assert (w_data[0] == 2)
    else $error("incorrect data at 0: %d", w_data[0]);
    assert (w_data[1] == 6)
    else $error("incorrect data at 1: %d", w_data[1]);
    assert (w_data[2] == 7)
    else $error("incorrect data at 2: %d", w_data[2]);
    assert (w_data[3] == 5)
    else $error("incorrect data at 3: %d", w_data[3]);

    $display("end of test");
  end
endmodule
