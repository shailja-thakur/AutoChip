module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

localparam [1:0] S0 = 2'd0, S1 = 2'd1, S2 = 2'd2;
reg [1:0] current_state, next_state;

always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        current_state <= S0;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        S0: begin
            if (x) begin
                next_state = S1;
                z = 1'b0;
            end
            else begin
                next_state = S0;
                z = 1'b0;
            end
        end
        S1: begin
            if (~x) begin
                next_state = S2;
                z = 1'b0;
            end
            else begin
                next_state = S1;
                z = 1'b0;
            end
        end
        S2: begin
            if (x) begin
                next_state = S1;
                z = 1'b1;
            end
            else begin
                next_state = S0;
                z = 1'b0;
            end
        end
        default: begin
            next_state = S0;
            z = 1'b0;
        end
    endcase
end

endmodule
