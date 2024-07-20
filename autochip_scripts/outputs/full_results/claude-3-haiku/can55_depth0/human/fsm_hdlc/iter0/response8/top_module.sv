module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

localparam [2:0] IDLE = 3'b000, WAIT1 = 3'b001, WAIT5 = 3'b010, FLAG = 3'b011, ERR = 3'b100;
reg [2:0] state, next_state;
reg [2:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        count <= 0;
        disc <= 0;
        flag <= 0;
        err <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
                if (in) begin
                    next_state <= WAIT1;
                    count <= 1;
                end
                else begin
                    next_state <= IDLE;
                    count <= 0;
                end
            end
            WAIT1: begin
                if (in) begin
                    next_state <= WAIT5;
                    count <= count + 1;
                end
                else begin
                    next_state <= IDLE;
                    count <= 0;
                end
            end
            WAIT5: begin
                if (in) begin
                    if (count == 4) begin
                        next_state <= FLAG;
                        disc <= 1;
                    end
                    else begin
                        next_state <= WAIT5;
                        count <= count + 1;
                    end
                end
                else begin
                    next_state <= IDLE;
                    count <= 0;
                end
            end
            FLAG: begin
                if (in) begin
                    if (count == 6) begin
                        next_state <= IDLE;
                        flag <= 1;
                    end
                    else begin
                        next_state <= WAIT5;
                        count <= count + 1;
                    end
                end
                else begin
                    next_state <= IDLE;
                    count <= 0;
                end
            end
            default: begin // ERR
                if (in) begin
                    next_state <= ERR;
                    err <= 1;
                end
                else begin
                    next_state <= IDLE;
                    err <= 0;
                end
            end
        endcase
    end
end

endmodule
