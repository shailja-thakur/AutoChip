module top_module(
    input clk,
    input areset,
    input x,
    output reg z
);

reg [2:0] state;

parameter [2:0] IDLE = 3'b000;
parameter [2:0] CONVERT = 3'b001;
parameter [2:0] COMPLEMENT = 3'b010;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= IDLE;
    else begin
        case (state)
            IDLE: begin
                if (~areset) begin
                    if (x)
                        state <= CONVERT;
                end
            end
            
            CONVERT: begin
                if (~areset) begin
                    z <= ~x;
                    state <= COMPLEMENT;
                end
            end
            
            COMPLEMENT: begin
                if (~areset) begin
                    z <= z + 1;
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
