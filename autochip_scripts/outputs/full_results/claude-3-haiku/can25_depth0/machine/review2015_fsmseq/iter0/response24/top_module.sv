module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // State definitions
    parameter S = 2'b00, S1 = 2'b01, S11 = 2'b10, S110 = 2'b11, DONE = 3'b100;

    // State register
    reg [2:0] state;

    always @(posedge clk or posedge reset) begin
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
            endcase
        end
    end

    // Output logic
    always @(*) begin
        case (state)
            DONE: start_shifting = 1'b1;
            default: start_shifting = 1'b0;
        endcase
    end

endmodule
