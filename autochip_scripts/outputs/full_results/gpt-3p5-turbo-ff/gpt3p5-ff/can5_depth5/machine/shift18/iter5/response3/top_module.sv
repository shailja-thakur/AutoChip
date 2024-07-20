module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q);

    reg [63:0] q_temp;
  
    always @(posedge clk) begin
        if (load) begin
            q_temp <= {q_temp[62:0], 1'b0};
        end
        else if (ena) begin
            case(amount)
                2'b00: q_temp <= {data[55:0], q_temp[7:0]};
                2'b01: q_temp <= {q_temp[63], data[55:0]};
                2'b10: q_temp <= {q_temp[63], q_temp[62:0]};
                2'b11: q_temp <= {q_temp[63], q_temp[63:1]};
                default: q_temp <= 64'hx;
            endcase
        end
    end
    
    always @(posedge clk) begin
        q <= q_temp;
    end

endmodule
