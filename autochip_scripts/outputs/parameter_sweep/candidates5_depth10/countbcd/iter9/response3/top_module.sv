module top_module(
  input clk,
  input reset,
  output reg[3:1] ena,
  output reg[15:0] q
);

  reg [15:0] q_next;     // register to hold next value of q

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 0;             // reset q to 0
      ena <= 0;           // reset ena to 0
    end else begin
      q <= q_next;        // update q with next value
      ena <= {q[13], q[9], q[5]};    // calculate ena
    end
  end

  always @(posedge clk) begin
    if (reset) begin
      q_next <= 0;        // initialize q_next to 0
    end else begin
      if (q[3:0] == 9) begin          // increment ones digit
        q_next[3:0] <= 0;
        if (q[7:4] == 9) begin        // increment tens digit
          q_next[7:4] <= 0;
          if (q[11:8] == 9) begin    // increment hundreds digit
            q_next[11:8] <= 0;
            if (q[15:12] == 9) begin // increment thousands digit
              q_next[15:12] <= 0;
            end else begin
              q_next[15:12] <= q[15:12] + 1;
            end
          end else begin
            q_next[11:8] <= q[11:8] + 1;
          end
        end else begin
          q_next[7:4] <= q[7:4] + 1;
        end
      end else begin
        q_next[3:0] <= q[3:0] + 1;
      end
    end
  end

endmodule
