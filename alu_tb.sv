module alu_tb;
  logic [3:0] r_a;
  logic [3:0] r_b;
  alu_operation_e r_op;
  wire [3:0] w_result;

  alu #(
      .Width(4)
  ) u0 (
      r_a,
      r_b,
      r_op,
      w_result
  );

  typedef struct {
    logic [3:0] a;
    logic [3:0] b;
    alu_operation_e op;
    logic [3:0] result;
  } record_t;

  initial begin
    record_t records[] = '{
        '{4'b0000, 4'b0001, ALU_OP_ADD, 4'b0001},
        '{4'b0010, 4'b0001, ALU_OP_OR, 4'b0011},
        '{4'b0010, 4'b0001, ALU_OP_AND, 4'b0000},
        '{4'b0010, 4'b0011, ALU_OP_XOR, 4'b0001},
        '{4'b0010, 4'b0011, ALU_OP_NOT, 4'b1101},
        '{4'b0010, 4'b0011, ALU_OP_NEG, 4'b1110},
        '{4'b1010, 4'b0001, ALU_OP_ASR, 4'b1101},
        '{4'b1010, 4'b0001, ALU_OP_LSL, 4'b0100}
    };

    for (int i = 0; i < records.size(); ++i) begin
      r_a  = records[i].a;
      r_b  = records[i].b;
      r_op = records[i].op;

      #5
      assert (w_result == records[i].result)
      else $error("invalid result for item %d: %d", i, w_result);
    end

    $display("end of test");
  end
endmodule
