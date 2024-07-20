module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam IDLE = 2'b00;
localparam WAIT_FIVE = 2'b01;
localparam ERROR = 2'b10;

reg [1:0] state, next_state;
reg [2:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        count <= 0;
        disc <= 0;
        flag <= 0;
        err <= 0;
    end else begin
        state <= next_state;
        case (state)
            IDLE: begin
                count <= 0;
                if (in) begin
                    next_state <= WAIT_FIVE;
                end else begin
                    next_state <= IDLE;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            WAIT_FIVE: begin
                count <= count + 1;
                if (in) begin
                    if (count == 3'b101) begin
                        next_state <= IDLE;
                        disc <= 1;
                    end else if (count == 3'b110) begin
                        next_state <= IDLE;
                        flag <= 1;
                    end else if (count == 3'b111) begin
                        next_state <= ERROR;
                        err <= 1;
                    end else begin
                        next_state <= WAIT_FIVE;
                    end
                end else begin
                    next_state <= IDLE;
                    count <= 0;
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
            end
            ERROR: begin
                next_state <= IDLE;
                disc <= 0;
                flag <= 0;
                err <= 1;
            end
        endcase
    end
end

endmodule
