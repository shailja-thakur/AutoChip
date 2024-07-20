module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
reg [1:0] state, next_state;
reg [7:0] accumulator;
reg [3:0] count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= S0;
        accumulator <= 0;
        count <= 0;
    end
    else begin
        state <= next_state;
        if (state == S1) begin
            accumulator <= accumulator + {7'b0000000, x};
            count <= count + 1;
        end
    end
end

always @(*) begin
    next_state = state;
    z = 0;
    case (state)
        S0: begin
            if (!areset) begin
                next_state = S1;
            end
        end
        S1: begin
            if (count == 4'b1000) begin
                next_state = S2;
                z = ~accumulator + 1;
            end
        end
        S2: begin
            z = 0;
        end
    endcase
end

endmodule
