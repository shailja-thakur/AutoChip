module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter INIT = 2'b00, CONVERT = 2'b01, DONE = 2'b11;
reg [1:0] state;
reg [7:0] result;
reg [3:0] count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= INIT;
        result <= 0;
        count <= 0;
        z <= 0;
    end
    else begin
        case (state)
            INIT: begin
                if (!x) begin
                    state <= CONVERT;
                    result <= 0;
                    count <= 0;
                end
                z <= 0;
            end
            CONVERT: begin
                result <= (result >> 1) | ({8{x}} << 7);
                count <= count + 1;
                if (count == 7) begin
                    state <= DONE;
                    z <= ~result[7];
                end
                else begin
                    z <= 0;
                end
            end
            DONE: begin
                z <= ~result[7];
            end
        endcase
    end
end

endmodule
