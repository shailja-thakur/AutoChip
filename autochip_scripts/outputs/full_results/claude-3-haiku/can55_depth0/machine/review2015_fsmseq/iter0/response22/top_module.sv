module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // States
    parameter S = 0, S1 = 1, S11 = 2, S110 = 3, Done = 4;

    reg [2:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S;
            start_shifting <= 0;
        end
        else begin
            case (state)
                S: begin
                    if (data) begin
                        state <= S1;
                        start_shifting <= 0;
                    end
                    else begin
                        state <= S;
                        start_shifting <= 0;
                    end
                end
                S1: begin
                    if (data) begin
                        state <= S11;
                        start_shifting <= 0;
                    end
                    else begin
                        state <= S;
                        start_shifting <= 0;
                    end
                end
                S11: begin
                    if (data) begin
                        state <= S11;
                        start_shifting <= 0;
                    end
                    else begin
                        state <= S110;
                        start_shifting <= 0;
                    end
                end
                S110: begin
                    if (data) begin
                        state <= Done;
                        start_shifting <= 1;
                    end
                    else begin
                        state <= S;
                        start_shifting <= 0;
                    end
                end
                Done: begin
                    state <= Done;
                    start_shifting <= 1;
                end
            endcase
        end
    end

endmodule
