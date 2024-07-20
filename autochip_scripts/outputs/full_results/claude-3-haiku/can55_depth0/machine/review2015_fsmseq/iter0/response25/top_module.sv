module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // Define the states of the state machine
    localparam S = 0, S1 = 1, S11 = 2, S110 = 3, Done = 4;

    // Declare the state register
    reg [2:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset the state to the initial state (S)
            state <= S;
        end else begin
            // Update the state based on the current state and the data input
            case (state)
                S: begin
                    if (data) begin
                        state <= S1;
                    end else begin
                        state <= S;
                    end
                end
                S1: begin
                    if (data) begin
                        state <= S11;
                    end else begin
                        state <= S;
                    end
                end
                S11: begin
                    if (data) begin
                        state <= S11;
                    end else begin
                        state <= S110;
                    end
                end
                S110: begin
                    if (data) begin
                        state <= Done;
                    end else begin
                        state <= S;
                    end
                end
                Done: begin
                    state <= Done;
                end
                default: begin
                    state <= S;
                end
            endcase
        end
    end

    // Assign the output based on the current state
    always @(*) begin
        case (state)
            Done: begin
                start_shifting = 1'b1;
            end
            default: begin
                start_shifting = 1'b0;
            end
        endcase
    end

endmodule
