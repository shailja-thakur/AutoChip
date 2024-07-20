module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state;
reg [1:0] next_state;

parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;

always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        state <= S0;
    end else begin
        state <= next_state;
    end
end

always @(state or x) begin
    case (state)
        S0: begin
            if (x == 1'b1) begin
                next_state <= S1;
            end else begin
                next_state <= S0;
            end
        end
        S1: begin
            if (x == 1'b0) begin
                next_state <= S2;
            end else begin
                next_state <= S0;
            end
        end
        S2: begin
            if (x == 1'b1) begin
                next_state <= S1;
                z <= 1'b1;
            end else begin
                next_state <= S0;
                z <= 1'b0;
            end
        end
    endcase
end

endmodule
