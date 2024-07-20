module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
reg [1:0] state, next_state;
reg [7:0] temp_num;
reg signed [7:0] neg_num;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= S0;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
        z <= neg_num[0];
    end
end

always @(*) begin
    case (state)
        S0: begin
            if (x) begin
                next_state = S1;
                temp_num = 8'b0;
            end
            else begin
                next_state = S0;
            end
        end
        S1: begin
            temp_num = {temp_num[6:0], x};
            if (x) begin
                next_state = S1;
            end
            else begin
                next_state = S2;
            end
        end
        S2: begin
            neg_num = ~temp_num + 1'b1;
            next_state = S0;
        end
        default: begin
            next_state = S0;
        end
    endcase
end

endmodule
