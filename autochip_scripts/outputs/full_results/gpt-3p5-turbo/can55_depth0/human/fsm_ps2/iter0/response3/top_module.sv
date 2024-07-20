module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    reg [7:0] inReg;
    reg [7:0] firstByte;
    reg [2:0] byteCount;
    reg doneReg;

    always @(posedge clk) begin
        if (reset) begin
            inReg <= 8'b0;
            firstByte <= 8'b0;
            byteCount <= 3'd0;
            doneReg <= 1'b0;
        end 
        else begin
            inReg <= in;
            
            if (byteCount == 3'd0) begin
                if (inReg[3] == 1'b1) begin
                    firstByte <= inReg;
                    byteCount <= 3'd1;
                end
            end
            else if (byteCount == 3'd1) begin
                byteCount <= 3'd2;
            end
            else if (byteCount == 3'd2) begin
                if (inReg[3] == 1'b1) begin
                    byteCount <= 3'd0;
                    doneReg <= 1'b1;
                end
                else begin
                    byteCount <= 3'd1;
                end
            end
        end
    end
    
    assign done = doneReg;

endmodule
