module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

    reg [2:0] state, next_state;

    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;
    parameter S5 = 3'b101;
    parameter S6 = 3'b110;
    parameter S7 = 3'b111;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    always @(state or in) begin
        case (state)
            S0: begin
                if (in) begin
                    next_state = S1;
                end else begin
                    next_state = S0;
                end
            end
            S1: begin
                if (in) begin
                    next_state = S2;
                end else begin
                    next_state = S0;
                end
            end
            S2: begin
                if (in) begin
                    next_state = S3;
                end else begin
                    next_state = S0;
                end
            end
            S3: begin
                if (in) begin
                    next_state = S4;
                end else begin
                    next_state = S0;
                end
            end
            S4: begin
                if (in) begin
                    next_state = S5;
                end else begin
                    next_state = S0;
                end
            end
            S5: begin
                if (in) begin
                    next_state = S6;
                    disc = 1;
                end else begin
                    next_state = S0;
                end
            end
            S6: begin
                if (in) begin
                    next_state = S7;
                    flag = 1;
                end else begin
                    next_state = S0;
                end
            end
            S7: begin
                if (in) begin
                    next_state = S7;
                    err = 1;
                end else begin
                    next_state = S0;
                end
            end
        endcase
    end
endmodule
