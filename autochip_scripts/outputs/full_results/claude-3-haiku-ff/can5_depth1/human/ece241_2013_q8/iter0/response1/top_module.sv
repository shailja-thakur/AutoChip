module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

localparam S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
reg [1:0] curr_state, next_state;

always @(posedge clk, negedge aresetn) begin
    if (~aresetn) begin
        curr_state <= S0;
    end
    else begin
        curr_state <= next_state;
    end
end

always @(*) begin
    next_state = curr_state;
    case (curr_state)
        S0: begin
            if (x) begin
                next_state = S1;
            end
            else begin
                next_state = S0;
            end
            z = 1'b0;
        end
        S1: begin
            if (x) begin
                next_state = S2;
            end
            else begin
                next_state = S0;
            end
            z = 1'b0;
        end
        S2: begin
            if (x) begin
                next_state = S1;
            end
            else begin
                next_state = S0;
            end
            z = 1'b1;
        end
    endcase
end

endmodule
