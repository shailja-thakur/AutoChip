module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [2:0] state;
reg [2:0] next_state;

// States
parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= S0;
        z <= 1'b0;
    end else begin
        state <= next_state;
        z <= (state == S2) ? 1'b1 : 1'b0;
    end
end

always @(state or x) begin
    case (state)
        S0: begin
            if (x) begin
                next_state <= S1;
            end else begin
                next_state <= S0;
            end
        end
        S1: begin
            if (x) begin
                next_state <= S2;
            end else begin
                next_state <= S0;
            end
        end
        S2: begin
            if (x) begin
                next_state <= S1;
            end else begin
                next_state <= S0;
            end
        end
        default: begin
            next_state <= S0;
        end
    endcase
end

endmodule
