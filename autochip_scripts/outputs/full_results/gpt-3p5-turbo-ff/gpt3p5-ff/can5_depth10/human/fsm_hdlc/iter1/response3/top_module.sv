module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    reg [3:0] state;
    reg [3:0] next_state;

    parameter S0 = 4'b0000;
    parameter S1 = 4'b0001;
    parameter S2 = 4'b0010;
    parameter S3 = 4'b0011;
    parameter S4 = 4'b0100;
    parameter S5 = 4'b0101;
    parameter S6 = 4'b0110;
    parameter S7 = 4'b0111;
    parameter S8 = 4'b1000;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state;

        case (state)
            S0: begin
                if (in)
                    next_state = S1;
            end
            S1: begin
                if (in)
                    next_state = S2;
                else
                    next_state = S0;
            end
            S2: begin
                if (in)
                    next_state = S2;
                else
                    next_state = S3;
            end
            S3: begin
                if (in)
                    next_state = S2;
                else
                    next_state = S4;
            end
            S4: begin
                if (in)
                    next_state = S2;
                else
                    next_state = S5;
            end
            S5: begin
                if (in)
                    next_state = S2;
                else
                    next_state = S6;
            end
            S6: begin
                if (in)
                    next_state = S2;
                else
                    next_state = S7;
            end
            S7: begin
                if (in)
                    next_state = S8;
                else
                    next_state = S0;
            end
            S8: begin
                if (in)
                    next_state = S2;
                else
                    next_state = S0;
            end
        endcase
    end

    always @(posedge clk) begin
        case (state)
            S0: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            S1: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            S2: begin
                disc <= 1;
                flag <= 0;
                err <= 0;
            end
            S3: begin
                disc <= 0;
                flag <= 1;
                err <= 0;
            end
            S4: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            S5: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            S6: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            S7: begin
                disc <= 0;
                flag <= 0;
                err <= 1;
            end
            S8: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
        endcase
    end
endmodule
