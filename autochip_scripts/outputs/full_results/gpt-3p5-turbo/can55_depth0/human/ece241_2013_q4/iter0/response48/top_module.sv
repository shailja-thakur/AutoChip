module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [3:0] state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 4'b0000;
    else begin
        case (state)
            4'b0000:
                if (s[3])
                    state <= 4'b0001;
                else
                    state <= 4'b0000;
                
            4'b0001:
                if (s[2])
                    state <= 4'b0010;
                else if (!s[3])
                    state <= 4'b0000;
                
            4'b0010:
                if (s[1])
                    state <= 4'b0100;
                else if (!s[2])
                    state <= 4'b0001;
                
            4'b0100:
                if (!s[1])
                    state <= 4'b0010;
                
        endcase
    end
end

always @(state) begin
    case (state)
        4'b0000:
            begin
                fr1 <= 1'b0;
                fr2 <= 1'b0;
                fr3 <= 1'b0;
                dfr <= 1'b0;
            end
            
        4'b0001:
            begin
                fr1 <= 1'b1;
                fr2 <= 1'b0;
                fr3 <= 1'b0;
                dfr <= 1'b0;
            end
            
        4'b0010:
            begin
                fr1 <= 1'b1;
                fr2 <= 1'b1;
                fr3 <= 1'b0;
                dfr <= 1'b0;
            end
            
        4'b0100:
            begin
                fr1 <= 1'b1;
                fr2 <= 1'b1;
                fr3 <= 1'b1;
                dfr <= 1'b1;
            end
    endcase
end

endmodule
