module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 

    // State machine variables
    reg [1:0] state = 2'b00;
    reg z = 1'b0;

    // Mealy-type state machine logic
    always @(posedge clk or posedge aresetn) begin
      if (aresetn) begin
        state <= 2'b00;
      end else begin
        case (state)
          2'b00:
            if (x == 1'b1) begin
              state <= 2'b01;
            end
          2'b01:
            if (x == 1'b0) begin
              state <= 2'b10;
            end
          2'b10:
            if (x == 1'b1) begin
              state <= 2'b00;
              z <= 1'b1;
            end
        endcase
      end
    end

endmodule