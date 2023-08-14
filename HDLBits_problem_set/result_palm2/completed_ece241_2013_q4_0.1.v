module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 

    parameter [3:0] STATES = 4'b0000;
    parameter [3:0] INIT_STATE = 3'b000;

    reg [3:0] state;
    reg [1:0] fr;
    reg [1:0] dfr;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= INIT_STATE;
        end else begin
            state <= state + 1'b1;
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            fr <= 2'b00;
            dfr <= 2'b00;
        end else begin
            case (state)
                3'b000: begin
                    if (s[2]) begin
                        fr <= 2'b00;
                        dfr <= 2'b00;
                    end else begin
                        fr <= 2'b00;
                        dfr <= 2'b01;
                    end
                end
                3'b001: begin
                    if (s[2]) begin
                        fr <= 2'b00;
                        dfr <= 2'b00;
                    end else begin
                        fr <= 2'b01;
                        dfr <= 2'b01;
                    end
                end
                3'b010: begin
                    if (s[2]) begin
                        fr <= 2'b00;
                        dfr <= 2'b00;
                    end else begin
                        fr <= 2'b01;
                        dfr <= 2'b10;
                    end
                end
                3'b011: begin
                    if (s[2]) begin
                        fr <= 2'b00;
                        dfr <= 2'b00;
                    end else begin
                        fr <= 2'b01;
                        dfr <= 2'b11;
                    end
                end
            endcase
        end
    end

    assign fr3 = fr[1];
    assign fr2 = fr[0];
    assign fr1 = fr[1] + fr[0];
    assign dfr = dfr[1];

endmodule