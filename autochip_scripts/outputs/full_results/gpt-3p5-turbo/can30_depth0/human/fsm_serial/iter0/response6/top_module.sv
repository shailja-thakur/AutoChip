module top_module (
    input clk,
    input in,
    input reset,
    output done
);

    reg [3:0] state;
    reg [7:0] data_reg;
    
    parameter IDLE = 3'b000;
    parameter START = 3'b001;
    parameter DATA = 3'b010;
    parameter STOP = 3'b011;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            data_reg <= 8'b0;
            done <= 1'b0;
        end
        else begin
            case (state)
                IDLE: begin
                    if (in == 1'b0) begin
                        state <= START;
                        data_reg <= 8'b0;
                    end
                end
                
                START: begin
                    state <= DATA;
                    data_reg[0] <= in;
                end
                
                DATA: begin
                    if (in == 1'b0) begin
                        data_reg[7:1] <= data_reg[6:0];
                        data_reg[0] <= in;
                    end
                    else begin
                        state <= STOP;
                    end
                end
                
                STOP: begin
                    if (in == 1'b1) begin
                        done <= 1'b1;
                    end
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule
