module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam [1:0] 
    IDLE = 2'b00,
    CONVERT = 2'b01,
    DONE = 2'b11;

reg [1:0] state;
reg [7:0] number;
reg [3:0] count;

always @(posedge clk, negedge areset) begin
    if (~areset) begin
        state <= IDLE;
        count <= 0;
        z <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (x) begin
                    state <= CONVERT;
                    number <= 0;
                    count <= 0;
                end
            end
            CONVERT: begin
                number <= {number[6:0], x};
                count <= count + 1;
                if (count == 7) begin
                    state <= DONE;
                    z <= ~number + 1;
                end
            end
            DONE: begin
                if (x) begin
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule
