module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
);

    always @(*) begin
        // Next state Y2 logic
        if (y[1] & w) begin
            Y2 = 1; // A -> A 
        end else if (y[2] & ~w) begin
            Y2 = 1; // B -> B 
        end else if (y[4] & w) begin
            Y2 = 1; // D -> A 
        end else if (y[5] & w) begin
            Y2 = 1; // E -> D 
        end else if (y[6] & w) begin
            Y2 = 1; // F -> D 
        end else begin
            Y2 = 0;
        end

        // Next state Y4 logic
        if (y[2] & w) begin
            Y4 = 1; // B -> D
        end else if (y[3] & w) begin
            Y4 = 1; // C -> D
        end else if (y[4] & w) begin
            Y4 = 1; // D -> A
        end else if (y[5] & w) begin
            Y4 = 1; // E -> D
        end else if (y[6] & w) begin
            Y4 = 1; // F -> D
        end else begin
            Y4 = 0;
        end
    end
    
endmodule
