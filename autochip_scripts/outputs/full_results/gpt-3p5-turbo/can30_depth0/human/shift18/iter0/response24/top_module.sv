module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q);

    reg [63:0] q_temp;

    always @ (posedge clk) begin
        if (load)
            q_temp <= data;
        else if (ena) begin
            case (amount)
                2'b00: q_temp <= {q_temp[62:0], q_temp[63]};
                2'b01: q_temp <= {q_temp[55:0], q_temp[63:56]};
                2'b10: q_temp <= {q_temp[0], q_temp[63:1]};
                2'b11: q_temp <= {q_temp[7:0], q_temp[63:8]};
            endcase
        end
    end

    assign q = q_temp;
    
endmodule
