module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

localparam S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;

always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        state <= S0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        S0: begin
            z = 0;
            if (x == 1'b0) begin
                next_state = S0;
            end
            else begin
                next_state = S1;
            end
        end
        S1: begin
            z = 0;
            if (x == 1'b0) begin
                next_state = S0;
            end
            else begin
                next_state = S2;
            end
        end
        S2: begin
            z = 1;
            if (x == 1'b0) begin
                next_state = S0;
            end
            else begin
                next_state = S1;
            end
        end
        default: begin
            z = 0;
            next_state = S0;
        end
    endcase
end

endmodule
