module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);

reg [4:0] state;

parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011;
parameter S4 = 3'b100;

always @(posedge clk)begin
    if(reset) begin
        state <= S0;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end else begin
        case(state)
            S0:begin
                if(s[1] && !s[2] && !s[3])
                    state <= S1;
                else if(s[1] && s[2] && !s[3]) begin
                    state <= S2;
                    dfr <= 1'b1;
                end else if(s[1] && s[2] && s[3])
                    state <= S3;
                else if(!s[1] && !s[2] && !s[3])
                    state <= S4;
            end
            S1:begin
                if(!s[1] && s[2] && !s[3])
                    state <= S2;
                else if(!s[1] && !s[2] && !s[3])
                    state <= S4;
            end
            S2:begin
                if(!s[1] && !s[2] && !s[3])
                    state <= S3;
            end
            S3:begin
                if(!s[1] && !s[2] && !s[3])
                    state <= S4;
            end
            S4:begin
                if(s[1] && !s[2] && !s[3])
                    state <= S1;
                else if(s[1] && s[2] && !s[3]) begin
                    state <= S2;
                    dfr <= 1'b1;
                end else if(s[1] && s[2] && s[3])
                    state <= S3;
            end
        endcase
    
        case(state)
            S0:begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
            end
            S1:begin
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b1;
            end
            S2:begin
                fr3 <= 1'b0;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
            end
            S3:begin
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
            end
            S4:begin
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
            end
        endcase
    end
end

endmodule
