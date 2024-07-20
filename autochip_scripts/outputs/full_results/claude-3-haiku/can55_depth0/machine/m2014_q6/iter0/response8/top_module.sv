module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Define the states
    localparam A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;

    // Register to store the current state
    reg [2:0] state;

    always @(posedge clk) begin
        if (reset) begin
            // Reset the state to A
            state <= A;
        end else begin
            // Update the state based on the current state and the input w
            case (state)
                A: begin
                    if (w) begin
                        state <= A;
                    end else begin
                        state <= B;
                    end
                end
                B: begin
                    if (w) begin
                        state <= D;
                    end else begin
                        state <= C;
                    end
                end
                C: begin
                    if (w) begin
                        state <= D;
                    end else begin
                        state <= E;
                    end
                end
                D: begin
                    if (w) begin
                        state <= A;
                    end else begin
                        state <= F;
                    end
                end
                E: begin
                    if (w) begin
                        state <= D;
                    end else begin
                        state <= E;
                    end
                end
                F: begin
                    if (w) begin
                        state <= D;
                    end else begin
                        state <= C;
                    end
                end
            endcase
        end
    end

    // Output z is high when the state is E or F, and low otherwise
    always @(*) begin
        case (state)
            E, F: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
