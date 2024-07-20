module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // Define the states
    localparam S = 0, S1 = 1, S11 = 2, S110 = 3, DONE = 4;

    // Register to store the current state
    reg [2:0] state;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= S;
        end
        else begin
            case (state)
                S: begin
                    if (data) begin
                        state <= S1;
                    end
                    else begin
                        state <= S;
                    end
                end
                S1: begin
                    if (data) begin
                        state <= S11;
                    end
                    else begin
                        state <= S;
                    end
                end
                S11: begin
                    if (data) begin
                        state <= S11;
                    end
                    else begin
                        state <= S110;
                    end
                end
                S110: begin
                    if (data) begin
                        state <= DONE;
                    end
                    else begin
                        state <= S;
                    end
                end
                DONE: begin
                    state <= DONE;
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
            DONE: start_shifting = 1'b1;
            default: start_shifting = 1'b0;
        endcase
    end

endmodule
