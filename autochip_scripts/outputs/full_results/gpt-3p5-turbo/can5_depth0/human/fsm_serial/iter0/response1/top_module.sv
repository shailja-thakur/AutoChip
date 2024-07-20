module top_module (
    input clk,
    input in,
    input reset,
    output done
);

reg [3:0] state;
reg [7:0] data;

parameter IDLE = 0;
parameter START = 1;
parameter RECEIVE = 2;
parameter STOP = 3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        data <= 8'b0;
    end else begin
        case(state)
            IDLE: begin
                if (in == 1'b0) begin
                    state <= START;
                end else begin
                    state <= IDLE;
                end
            end
            
            START: begin
                state <= RECEIVE;
                data <= 8'b0;
            end
            
            RECEIVE: begin
                if (in == 1'b0) begin
                    data <= {data[6:0], in};
                end else begin
                    state <= STOP;
                end
            end
            
            STOP: begin
                if (in == 1'b1) begin
                    state <= IDLE;
                    done <= 1'b1;
                end else begin
                    state <= STOP;
                    done <= 1'b0;
                end
            end
        endcase
    end
end

endmodule
