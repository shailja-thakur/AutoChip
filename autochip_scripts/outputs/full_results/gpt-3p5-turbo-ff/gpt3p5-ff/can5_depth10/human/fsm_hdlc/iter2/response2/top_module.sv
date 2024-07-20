module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    reg [3:0] state;

    parameter S0 = 4'b0000;
    parameter S1 = 4'b0001;
    parameter S2 = 4'b0010;
    parameter S3 = 4'b0011;
    parameter S4 = 4'b0100;
    parameter S5 = 4'b0101;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else begin
            case (state)
                S0: begin
                    if (in)
                        state <= S1;
                    else
                        state <= S0;
                end
                S1: begin
                    if (in)
                        state <= S2;
                    else
                        state <= S0;
                end
                S2: begin
                    if (in)
                        state <= S3;
                    else
                        state <= S0;
                end
                S3: begin
                    if (in)
                        state <= S4;
                    else
                        state <= S0;
                end
                S4: begin
                    if (in)
                        state <= S3;
                    else
                        state <= S5;
                end
                S5: begin
                    if (in)
                        state <= S2;
                    else
                        state <= S0;
                end
            endcase
        end
    end

    always @(state) begin
        case (state)
            S0: begin
                disc = 0;
                flag = 0;
                err = 0;
            end
            S1: begin
                disc = 0;
                flag = 0;
                err = 0;
            end
            S2: begin
                disc = 1;
                flag = 0;
                err = 0;
            end
            S3: begin
                disc = 0;
                flag = 0;
                err = 1;
            end
            S4: begin
                disc = 0;
                flag = 1;
                err = 0;
            end
            S5: begin
                disc = 0;
                flag = 0;
                err = 0;
            end
        endcase
    end
endmodule
