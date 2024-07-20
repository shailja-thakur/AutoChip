module top_module (
    input clk,
    input in,
    input reset,
    output done
);

// State definition
parameter IDLE = 2'b00;
parameter START = 2'b01;
parameter DATA = 2'b10;
parameter STOP = 2'b11;

// State register
reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        case (state)

            IDLE: begin
                if (in == 1'b0) begin
                    state <= START;
                end
            end

            START: begin
                state <= DATA;
            end

            DATA: begin
                if (in == 1'b1) begin
                    state <= STOP;
                end
            end

            STOP: begin
                if (in == 1'b1) begin
                    state <= IDLE;
                end
            end

            default: state <= IDLE;
        endcase
    end
end

// Output logic
assign done = (state == STOP);

endmodule
