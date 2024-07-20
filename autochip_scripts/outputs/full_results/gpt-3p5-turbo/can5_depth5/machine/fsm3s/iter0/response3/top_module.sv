module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    reg [1:0] state;
    // Define the four states
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A; // Reset the state to A
            out <= 0;   // Set out to 0
        end else begin
            case(state)
                A: begin
                    if (in) begin
                        state <= B; // Change state to B
                    end else begin
                        state <= A; // Remain in state A
                    end
                end
                B: begin
                    if (in) begin
                        state <= B; // Remain in state B
                    end else begin
                        state <= C; // Change state to C
                    end
                end
                C: begin
                    if (in) begin
                        state <= D; // Change state to D
                    end else begin
                        state <= A; // Change state to A
                    end
                end
                D: begin
                    if (in) begin
                        state <= B; // Change state to B
                    end else begin
                        state <= C; // Change state to C
                    end
                end
            endcase
            if (state == D) begin
                out <= 1; // Set out to 1 when state is D
            end else begin
                out <= 0; // Set out to 0 for other states
            end
        end
    end
endmodule
