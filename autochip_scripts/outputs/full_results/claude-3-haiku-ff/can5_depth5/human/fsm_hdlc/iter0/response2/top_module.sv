module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

reg [2:0] state;
parameter [2:0] IDLE = 3'b000,
                WAIT1 = 3'b001,
                WAIT2 = 3'b010,
                WAIT3 = 3'b011,
                WAIT4 = 3'b100,
                WAIT5 = 3'b101,
                FLAG = 3'b110,
                ERROR = 3'b111;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        disc <= 0;
        flag <= 0;
        err <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in) begin
                    state <= WAIT1;
                end else begin
                    state <= IDLE;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            WAIT1: begin
                if (in) begin
                    state <= WAIT2;
                end else begin
                    state <= IDLE;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            WAIT2: begin
                if (in) begin
                    state <= WAIT3;
                end else begin
                    state <= IDLE;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            WAIT3: begin
                if (in) begin
                    state <= WAIT4;
                end else begin
                    state <= IDLE;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            WAIT4: begin
                if (in) begin
                    state <= WAIT5;
                end else begin
                    state <= IDLE;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            WAIT5: begin
                if (in) begin
                    state <= FLAG;
                    disc <= 1;
                end else begin
                    state <= IDLE;
                end
                flag <= 0;
                err <= 0;
            end
            FLAG: begin
                if (in) begin
                    state <= ERROR;
                    flag <= 1;
                end else begin
                    state <= IDLE;
                end
                disc <= 0;
                err <= 0;
            end
            ERROR: begin
                if (in) begin
                    state <= ERROR;
                end else begin
                    state <= IDLE;
                end
                disc <= 0;
                flag <= 0;
                err <= 1;
            end
        endcase
    end
end

endmodule
