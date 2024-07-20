module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);
	
    reg [2:0] state;
    reg [7:0] data_reg;
    reg [2:0] count;
	
    parameter IDLE = 3'b000;
    parameter START = 3'b001;
    parameter DATA = 3'b010;
    parameter STOP = 3'b011;
    parameter VALID = 3'b100;
	
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            data_reg <= 8'b0;
            count <= 3'b0;
        end else begin
            case (state)
                IDLE: begin
                    if (in == 1'b0) begin
                        state <= START;
                        data_reg <= 8'b0;
                        count <= 3'b0;
                    end
                end
                START: begin
                    if (in == 1'b0) begin
                        state <= DATA;
                        count <= 3'b0;
                    end else begin
                        state <= IDLE;
                    end
                end
                DATA: begin
                    if (count < 3'b100) begin
                        data_reg <= {in, data_reg[7:1]};
                        count <= count + 1;
                    end else begin
                        state <= STOP;
                    end
                end
                STOP: begin
                    if (in == 1'b1) begin
                        state <= VALID;
                    end else begin
                        state <= IDLE;
                    end
                end
                VALID: begin
                    state <= IDLE;
                end
            endcase
        end
    end
	
    assign out_byte = data_reg;
    assign done = (state == VALID);
	
endmodule
