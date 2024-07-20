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

reg [3:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        count <= 0;
        disc <= 0;
        flag <= 0;
        err <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (in) begin
                    state <= WAIT1;
                    count <= 1;
                end else begin
                    state <= IDLE;
                    count <= 0;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            WAIT1: begin
                if (in) begin
                    state <= WAIT2;
                    count <= count + 1;
                end else begin
                    state <= IDLE;
                    count <= 0;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            WAIT2: begin
                if (in) begin
                    state <= WAIT3;
                    count <= count + 1;
                end else begin
                    state <= IDLE;
                    count <= 0;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            WAIT3: begin
                if (in) begin
                    state <= WAIT4;
                    count <= count + 1;
                end else begin
                    state <= IDLE;
                    count <= 0;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            WAIT4: begin
                if (in) begin
                    state <= WAIT5;
                    count <= count + 1;
                end else begin
                    state <= IDLE;
                    count <= 0;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            WAIT5: begin
                if (in) begin
                    if (count == 5) begin
                        state <= FLAG;
                        disc <= 1;
                        count <= 0;
                    end else begin
                        state <= WAIT1;
                        count <= count + 1;
                    end
                end else begin
                    state <= IDLE;
                    count <= 0;
                end
                flag <= 0;
                err <= 0;
            end
            FLAG: begin
                if (in) begin
                    if (count == 7) begin
                        state <= ERROR;
                        flag <= 0;
                        err <= 1;
                        count <= 0;
                    end else begin
                        state <= FLAG;
                        flag <= 1;
                        count <= count + 1;
                    end
                end else begin
                    state <= IDLE;
                    flag <= 0;
                    count <= 0;
                end
                disc <= 0;
            end
            ERROR: begin
                if (in) begin
                    state <= ERROR;
                    err <= 1;
                    count <= count + 1;
                end else begin
                    state <= IDLE;
                    err <= 0;
                    count <= 0;
                end
                disc <= 0;
                flag <= 0;
            end
        endcase
    end
end

endmodule
