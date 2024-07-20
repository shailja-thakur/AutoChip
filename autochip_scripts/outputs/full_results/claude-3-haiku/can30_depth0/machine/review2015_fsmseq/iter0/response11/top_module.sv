module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // Define the states
    localparam S = 2'b00, S1 = 2'b01, S11 = 2'b10, S110 = 2'b11, DONE = 3'b100;

    // Register to store the current state
    reg [2:0] state;

    // Update the state on the rising edge of the clock
    always @(posedge clk) begin
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
            DONE: begin
                start_shifting = 1'b1;
            end
            default: begin
                start_shifting = 1'b0;
            end
        endcase
    end

endmodule
