module top_module (
    input clk,
    input in,
    input reset,
    output done
);

    reg [2:0] state;
    reg start_bit_detected;
    reg [7:0] data;
    
    parameter IDLE = 3'b000;
    parameter START_BIT = 3'b001;
    parameter DATA_BIT = 3'b010;
    parameter STOP_BIT = 3'b011;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            start_bit_detected <= 0;
            data <= 8'b0;
        end else begin
            case(state)
                IDLE: begin
                    if (in == 1'b0) begin
                        state <= START_BIT;
                        start_bit_detected <= 1'b1;
                    end
                end
                START_BIT: begin
                    if (in == 1'b0) begin
                        state <= DATA_BIT;
                        data <= 8'b0;
                    end else begin
                        state <= IDLE;
                        start_bit_detected <= 0;
                    end
                end
                DATA_BIT: begin
                    if (in == 1'b0) begin
                        data <= {data[6:0], in};
                    end else begin
                        state <= STOP_BIT;
                    end
                end
                STOP_BIT: begin
                    if (in == 1'b1 && start_bit_detected == 1'b1) begin
                        done <= 1'b1;
                    end else begin
                        state <= IDLE;
                        start_bit_detected <= 0;
                    end
                end
            endcase
        end
    end
endmodule
