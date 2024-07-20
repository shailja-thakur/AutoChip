module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // Parameters for the state values
    parameter A = 2'b00, B = 2'b01, C = 2'b11;

    // Register to store the current state
    reg [1:0] state;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the state to A
            state <= A;
        end
        else begin
            case (state)
                A: begin
                    if (x) begin
                        state <= C;
                    end
                    else begin
                        state <= A;
                    end
                end
                B: begin
                    if (x) begin
                        state <= B;
                    end
                    else begin
                        state <= C;
                    end
                end
                C: begin
                    if (x) begin
                        state <= B;
                    end
                    else begin
                        state <= C;
                    end
                end
                default: begin
                    state <= A;
                end
            endcase
        end
    end

    // Assign the output based on the state
    always @(*) begin
        case (state)
            C: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
