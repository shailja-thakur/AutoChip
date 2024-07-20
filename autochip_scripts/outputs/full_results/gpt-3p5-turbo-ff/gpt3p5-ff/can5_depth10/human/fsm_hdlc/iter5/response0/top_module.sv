module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    reg [2:0] state;
    reg [5:0] count;

    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S0;
            count <= 0;
        end
        else begin
            case (state)
                S0: begin
                    if (in) begin
                        count <= count + 1;
                        state <= S1;
                    end else begin
                        count <= 0;
                        state <= S0;
                    end  
                end
                S1: begin
                    if (in) begin
                        count <= count + 1;
                        state <= S1;
                    end else begin
                        if (count >= 5)  begin
                            count <= 0;
                            state <= S3;
                        end else begin
                            count <= 0;
                            state <= S2;
                        end
                    end
                end
                S2: begin
                    if (in) begin
                        count <= count + 1;
                        state <= S1;
                    end else begin
                        count <= 0;
                        state <= S0;                        
                    end
                end
                S3: begin
                    if (in) begin
                        count <= 0;
                        state <= S4;
                    end else begin
                        count <= 0;
                        state <= S0;                        
                    end
                end
                S4: begin
                    if (in) begin
                        count <= count + 1;
                        state <= S1;
                    end else begin
                        count <= 0;
                        state <= S3;                        
                    end
                end
            endcase
        end
    end

    always @(state) begin
        case (state)
            S2: begin
                disc = 1;
                flag = 0;
                err = 0;
            end
            S3: begin
                disc = 0;
                flag = 1;
                err = 0;
            end
            S4: begin
                disc = 0;
                flag = 0;
                err = 1;
            end
            default: begin
                disc = 0;
                flag = 0;
                err = 0;
            end
        endcase
    end
endmodule
