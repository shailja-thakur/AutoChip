module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

reg [1:0] state;
reg [2:0] count;
reg first_byte_found;
reg second_byte_found;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= 0;
    count <= 0;
    first_byte_found <= 0;
    second_byte_found <= 0;
  end else begin
    case (state)
      0: begin  // Idle state
        if (in[3] == 1 && !first_byte_found) begin
          state <= 1;    // Transition to first byte state
          first_byte_found <= 1;
        end
      end
      1: begin  // First byte state
        if (count == 1) begin
          state <= 2;  // Transition to second byte state
          second_byte_found <= 1;
        end
      end
      2: begin  // Second byte state
        if (count == 2) begin
          state <= 0;  // Transition to idle state
        end
      end
    endcase

    if (first_byte_found && second_byte_found && count == 2) begin
      count <= 0;
    end else if (state != 0) begin
      count <= count + 1;
    end
  end
end

assign done = (state == 2 && count == 2);

endmodule
