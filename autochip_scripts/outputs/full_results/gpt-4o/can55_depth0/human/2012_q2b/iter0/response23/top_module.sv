module top_module (
    input [5:0] y,
    input w,
    output reg Y1,
    output reg Y3
);

    // One-hot state representations
    parameter A = 6'b000001;
    parameter B = 6'b000010;
    parameter C = 6'b000100;
    parameter D = 6'b001000;
    parameter E = 6'b010000;
    parameter F = 6'b100000;

    always @(*) begin
        // Default assignment to avoid latches
        Y1 = 1'b0;
        Y3 = 1'b0;

        case (y)
            A: begin
                Y1 = w;   // A --> B if w==1
            end
            B: begin
                if (w == 1) 
                    Y1 = 1'b0; // B --> C if w==1
                else 
                    Y1 = 1'b1; // B --> D if w==0
            end
            C: begin
                if (w == 1) 
                    Y1 = 1'b0; // C --> E if w==1
                else 
                    Y1 = 1'b1; // C --> D if w==0
            end
            D: begin
                if (w == 1) 
                    Y1 = 1'b0; // D --> F if w==1
                else 
                    Y1 = 1'b1; // D --> A if w==0
            end
            E: begin
                if (w == 0) 
                    Y1 = 1'b1; // E --> D if w==0
            end
            F: begin
                if (w == 0) 
                    Y1 = 1'b1; // F --> D if w==0
                else
                    Y1 = 1'b0; // F --> C if w==1
            end
        endcase

        case (y)
            B: begin
                if (w == 0) 
                    Y3 = 1'b1; // B --> D if w==0
            end
            C: begin
                if (w == 0) 
                    Y3 = 1'b1; // C --> D if w==0
            end
            D: begin
                Y3 = 1'b1;   // Existing in state D or going to state D
            end
            E: begin
                if (w == 0) 
                    Y3 = 1'b1; // E --> D if w==0
            end
            F: begin
                if (w == 0) 
                    Y3 = 1'b1; // F --> D if w==0
            end
        endcase
    end
endmodule
