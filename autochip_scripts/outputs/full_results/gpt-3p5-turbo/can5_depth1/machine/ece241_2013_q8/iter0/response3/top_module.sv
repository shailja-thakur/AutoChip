module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [3:0] state, next_state;

parameter S = 4'b000;
parameter S1 = 4'b001;
parameter S10 = 4'b010;

always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        state <= S;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        S: begin
            if (x == 1'b0) begin
                next_state = S;
            end else begin
                next_state = S1;
            end
            z = 1'b0;
        end
        S1: begin
            if (x == 1'b0) begin
                next_state = S10;
            end else begin
                next_state = S1;
            end
            z = 1'b0;
        end
        S10: begin
            if (x == 1'b0) begin
                next_state = S;
            end else begin
                next_state = S1;
            end
            z = x;
        end
        default: begin
            next_state = S;
            z = 1'b0;
        end
    endcase
end

endmodule
