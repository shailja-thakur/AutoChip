module top_module (
    input clk,
    input in,
    input reset,
    output done
);

reg [2:0] state;
reg [7:0] data_byte;
reg start_detected;
reg stop_detected;

parameters IDLE = 3'b000;
parameters START = 3'b001;
parameters DATA = 3'b010;
parameters STOP = 3'b011;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        data_byte <= 8'b0;
        start_detected <= 1'b0;
        stop_detected <= 1'b0;
        done <= 1'b0;
    end else begin
        case (state)
            IDLE: begin
                if (in == 1'b0)
                    state <= START;
            end
            START: begin
                if (in == 1'b0)
                begin
                    start_detected <= 1'b1;
                    state <= DATA;
                end
            end
            DATA: begin
                if (in == 1'b1)
                begin
                    data_byte <= {in, data_byte[7:1]};
                    state <= DATA;
                end
                else if (in == 1'b0)
                    state <= STOP;
            end
            STOP: begin
                if (in == 1'b1)
                begin
                    stop_detected <= 1'b1;
                    if (start_detected && stop_detected)
                        done <= 1'b1;
                    state <= IDLE;
                end
            end
            default: state <= IDLE;
        endcase
    end
end

endmodule
