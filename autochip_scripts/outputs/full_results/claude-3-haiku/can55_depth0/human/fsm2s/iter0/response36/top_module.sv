module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

localparam [1:0] 
    OFF = 2'b00,
    ON = 2'b01;

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= OFF;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        OFF: begin
            if (j) begin
                next_state = ON;
                out = 0;
            end
            else begin
                next_state = OFF;
                out = 0;
            end
        end
        ON: begin
            if (k) begin
                next_state = OFF;
                out = 1;
            end
            else begin
                next_state = ON;
                out = 1;
            end
        end
        default: begin
            next_state = OFF;
            out = 0;
        end
    endcase
end

endmodule
