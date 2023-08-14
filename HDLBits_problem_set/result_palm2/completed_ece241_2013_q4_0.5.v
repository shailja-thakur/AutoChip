module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 

    parameter [3:0] S_1 = 1'b0;
    parameter [3:0] S_2 = 1'b1;
    parameter [3:0] S_3 = 1'b10;

    localparam IDLE = 4'h0;
    localparam LEVEL1 = 4'h1;
    localparam LEVEL2 = 4'h2;
    localparam LEVEL3 = 4'h3;

    reg [3:0] state;
    reg [1:0] fr;
    reg [1:0] dfr;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            fr <= 2'b00;
            dfr <= 2'b00;
        end else begin
            switch (state) begin
                case (IDLE) begin
                    if (s[0]) begin
                        state <= LEVEL1;
                        fr <= 2'b01;
                        dfr <= 2'b00;
                    end else if (s[1]) begin
                        state <= LEVEL2;
                        fr <= 2'b10;
                        dfr <= 2'b00;
                    end else if (s[2]) begin
                        state <= LEVEL3;
                        fr <= 2'b11;
                        dfr <= 2'b00;
                    end
                end
                case (LEVEL1) begin
                    if (s[0] == 1'b0) begin
                        state <= IDLE;
                        fr <= 2'b00;
                        dfr <= 2'b00;
                    end
                end
                case (LEVEL2) begin
                    if (s[1] == 1'b0) begin
                        state <= LEVEL1;
                        fr <= 2'b00;
                        dfr <= 2'b00;
                    end
                end
                case (LEVEL3) begin
                    if (s[2] == 1'b0) begin
                        state <= LEVEL2;
                        fr <= 2'b00;
                        dfr <= 2'b00;
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