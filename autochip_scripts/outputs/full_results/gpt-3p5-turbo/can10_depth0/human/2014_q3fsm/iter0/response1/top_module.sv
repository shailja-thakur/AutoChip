module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;   // Declare a two-bit register for the FSM state

parameter A = 2'b00;   // Define the reset state
parameter B = 2'b01;   // Define the state where s = 1

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;   // Reset the FSM to state A
        z <= 0;       // Reset the output z to 0
    end
    else begin
        case (state)
            A: begin   // FSM is in state A
                if (s) begin
                    state <= B;   // Move to state B if s = 1
                end
            end
            B: begin   // FSM is in state B
                if (w) begin
                    state <= A;   // Move back to state A if w = 1
                    z <= 0;       // Set output z to 0
                end
                else begin
                    state <= B;   // Stay in state B if w = 0
                    z <= 0;       // Set output z to 0

                    if (~w) begin   // Check w for the next three clock cycles
                        if (w) begin
                            z <= 0;   // Set output z to 0 if w = 1 in all three cycles
                        end
                        else begin
                            z <= 1;   // Set output z to 1 if w = 1 in exactly two cycles
                        end
                    end
                end
            end
        endcase
    end
end

endmodule
