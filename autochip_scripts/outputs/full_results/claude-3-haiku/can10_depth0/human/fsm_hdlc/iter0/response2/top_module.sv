module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

parameter S0 = 3'd0, S1 = 3'd1, S2 = 3'd2, S3 = 3'd3, S4 = 3'd4, S5 = 3'd5, S6 = 3'd6;
reg [2:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= S0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    disc = 0;
    flag = 0;
    err = 0;
    case (state)
        S0: begin
            if (in == 1'b0) begin
                next_state = S1;
            end
            else begin
                next_state = S0;
            end
        end
        S1: begin
            if (in == 1'b1) begin
                next_state = S2;
            end
            else begin
                next_state = S1;
            end
        end
        S2: begin
            if (in == 1'b1) begin
                next_state = S3;
            end
            else begin
                next_state = S1;
            end
        end
        S3: begin
            if (in == 1'b1) begin
                next_state = S4;
            end
            else begin
                next_state = S1;
            end
        end
        S4: begin
            if (in == 1'b1) begin
                next_state = S5;
            end
            else begin
                next_state = S1;
            end
        end
        S5: begin
            if (in == 1'b0) begin
                next_state = S6;
                disc = 1'b1;
            end
            else begin
                next_state = S0;
                err = 1'b1;
            end
        end
        S6: begin
            if (in == 1'b1) begin
                next_state = S0;
                flag = 1'b1;
            end
            else begin
                next_state = S1;
            end
        end
        default: begin
            next_state = S0;
        end
    endcase
end

endmodule
