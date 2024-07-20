module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);
    reg [2:0] state;
    reg [2:0] next_state;
    
    parameter IDLE = 3'b000;
    parameter ABOVE_S3 = 3'b001;
    parameter BETWEEN_S3_S2 = 3'b010;
    parameter BETWEEN_S2_S1 = 3'b011;
    parameter BELOW_S1 = 3'b100;
    
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            fr3 <= 1'b1;
            fr2 <= 1'b1;
            fr1 <= 1'b1;
            dfr <= 1'b1;
            state <= IDLE;
        end else begin
            case(state)
                IDLE: begin
                    if(s[3]) begin
                        state <= ABOVE_S3;
                    end else if(s[2]) begin
                        state <= BETWEEN_S3_S2;
                    end else if(s[1]) begin
                        state <= BETWEEN_S2_S1;
                    end else begin
                        state <= BELOW_S1;
                    end
                    
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                end
                
                ABOVE_S3: begin
                    if(!s[3]) begin
                        if(s[2]) begin
                            state <= BETWEEN_S3_S2;
                        end else if(s[1]) begin
                            state <= BETWEEN_S2_S1;
                        end else begin
                            state <= BELOW_S1;
                        end
                    end
                    
                    fr3 <= 1'b0;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                end
                
                BETWEEN_S3_S2: begin
                    if(!s[2]) begin
                        if(s[1]) begin
                            state <= BETWEEN_S2_S1;
                        end else begin
                            state <= BELOW_S1;
                        end
                    end
                    
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                end
                
                BETWEEN_S2_S1: begin
                    if(!s[1]) begin
                        state <= BELOW_S1;
                    end
                    
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    dfr <= 1'b1;
                end
                
                BELOW_S1: begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b1;
                end
            endcase
        end
    end
endmodule
