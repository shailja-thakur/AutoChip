module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

// State variables
reg [1:0] state;
localparam [1:0] IDLE = 2'b00, RISING_EDGE = 2'b01, HIGH = 2'b10, FALLING_EDGE = 2'b11;

always @(posedge clock) begin
    case (state)
        IDLE: begin
            p <= 0;
            q <= 0;
            if (a) begin
                state <= RISING_EDGE;
            end else begin
                state <= IDLE;
            end
        end
        RISING_EDGE: begin
            p <= 0;
            q <= 0;
            state <= HIGH;
        end
        HIGH: begin
            p <= 0;
            q <= 1;
            if (~a) begin
                state <= FALLING_EDGE;
            end else begin
                state <= HIGH;
            end
        end
        FALLING_EDGE: begin
            p <= 1;
            q <= 1;
            state <= IDLE;
        end
        default: begin
            p <= 0;
            q <= 0;
            state <= IDLE;
        end
    endcase
end

endmodule
