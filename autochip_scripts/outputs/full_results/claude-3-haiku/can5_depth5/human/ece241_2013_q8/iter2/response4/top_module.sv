module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

localparam S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
reg [1:0] state, next_state;

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
            if (x) begin
                next_state = S1;
            end
            else begin
                next_state = S0;
            end
        end
        S1: begin
            z = 0;
            if (~x) begin
                next_state = S2;
            end
            else begin
                next_state = S1;
            end
        end
        S2: begin
            z = (x) ? 1 : 0;
            next_state = (x) ? S1 : S0;
        end
        default: begin
            z = 0;
            next_state = S0;
        end
    endcase
end

endmodule
