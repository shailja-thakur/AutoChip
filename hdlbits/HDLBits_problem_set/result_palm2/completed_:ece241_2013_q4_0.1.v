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
    reg [3:0] s_prev;
    reg [1:0] fr;
    reg [1:0] dfr;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= INIT_STATE;
            s_prev <= 3'b000;
            fr <= 1'b0;
            dfr <= 1'b0;
        end else begin
            switch (state) begin
                case (3'b000) begin
                    if (s[1] && s[2] && s[3]) begin
                        state <= 3'b001;
                        fr <= 1'b0;
                        dfr <= 1'b0;
                    end
                end
                case (3'b001) begin
                    if (s[1] && s[2]) begin
                        state <= 3'b010;
                        fr <= 1'b1;
                        dfr <= 1'b0;
                    end
                end
                case (3'b010) begin
                    if (s[1]) begin
                        state <= 3'b011;
                        fr <= 1'b1;
                        dfr <= 1'b1;
                    end
                end
                case (3'b011) begin
                    if (s[0] == s_prev) begin
                        state <= 3'b000;
                        fr <= 1'b0;
                        dfr <= 1'b0;
                    end else begin
                        state <= 3'b001;
                        fr <= 1'b0;
                        dfr <= 1'b0;
                    end
                end
            endcase
        end
    end

    assign fr3 = fr[1];
    assign fr2 = fr[0];
    assign fr1 = fr[0];
    assign dfr = dfr[1];

endmodule