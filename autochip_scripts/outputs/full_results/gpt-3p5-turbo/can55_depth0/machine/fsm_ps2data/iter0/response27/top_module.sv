module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [2:0] state;
    
    always@(posedge clk or posedge reset) begin
        if(reset) begin
            state <= 3'b000;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            case(state)
                3'b000: begin
                           if(in[2] == 1) begin
                               state <= 3'b001;
                           end else begin
                               state <= 3'b000;
                           end
                       end
                3'b001: begin
                           state <= 3'b010;
                       end
                3'b010: begin
                           state <= 3'b011;
                       end
                3'b011: begin
                           state <= 3'b111;
                       end
                3'b111: begin
                           if(in[2] == 1) begin
                               state <= 3'b001;
                           end else begin
                               state <= 3'b000;
                           end
                       end
            endcase
        end
    end

    always@(posedge clk) begin
        if(done == 1'b1) begin
            out_bytes <= out_bytes << 8;
            out_bytes[7:0] <= in;
        end
    end

    always@(posedge clk) begin
        if(state == 3'b111) begin
            done <= 1'b1;
        end else begin
            done <= 1'b0;
        end
    end

endmodule
